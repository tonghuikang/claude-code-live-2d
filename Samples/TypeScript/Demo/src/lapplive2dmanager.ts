/**
 * Copyright(c) Live2D Inc. All rights reserved.
 *
 * Use of this source code is governed by the Live2D Open Software license
 * that can be found at https://www.live2d.com/eula/live2d-open-software-license-agreement_en.html.
 */

import { CubismMatrix44 } from '@framework/math/cubismmatrix44';
import { ACubismMotion } from '@framework/motion/acubismmotion';
import { csmVector } from '@framework/type/csmvector';

import * as LAppDefine from './lappdefine';
import { LAppModel } from './lappmodel';
import { LAppPal } from './lapppal';
import { LAppSubdelegate } from './lappsubdelegate';
import { ActionClient, Action } from './actionclient';

/**
 * サンプルアプリケーションにおいてCubismModelを管理するクラス
 * モデル生成と破棄、タップイベントの処理、モデル切り替えを行う。
 */
export class LAppLive2DManager {
  private _actionQueue: Action[] = [];
  private _isProcessingAction: boolean = false;

  /**
   * 現在のシーンで保持しているすべてのモデルを解放する
   */
  private releaseAllModel(): void {
    this._models.clear();
  }

  /**
   * 画面をドラッグした時の処理
   *
   * @param x 画面のX座標
   * @param y 画面のY座標
   */
  public onDrag(x: number, y: number): void {
    const model: LAppModel = this._models.at(0);
    if (model) {
      model.setDragging(x, y);
    }
  }

  /**
   * 画面をタップした時の処理
   *
   * @param x 画面のX座標
   * @param y 画面のY座標
   */
  public onTap(x: number, y: number): void {
    if (LAppDefine.DebugLogEnable) {
      LAppPal.printMessage(
        `[APP]tap point: {x: ${x.toFixed(2)} y: ${y.toFixed(2)}}`
      );
    }

    const model: LAppModel = this._models.at(0);

    if (model.hitTest(LAppDefine.HitAreaNameHead, x, y)) {
      if (LAppDefine.DebugLogEnable) {
        LAppPal.printMessage(`[APP]hit area: [${LAppDefine.HitAreaNameHead}]`);
      }
      model.setRandomExpression();
    } else if (model.hitTest(LAppDefine.HitAreaNameBody, x, y)) {
      if (LAppDefine.DebugLogEnable) {
        LAppPal.printMessage(`[APP]hit area: [${LAppDefine.HitAreaNameBody}]`);
      }
      model.startRandomMotion(
        LAppDefine.MotionGroupTapBody,
        LAppDefine.PriorityNormal,
        this.finishedMotion,
        this.beganMotion
      );
    }
  }

  /**
   * 画面を更新するときの処理
   * モデルの更新処理及び描画処理を行う
   */
  public onUpdate(): void {
    const { width, height } = this._subdelegate.getCanvas();

    const projection: CubismMatrix44 = new CubismMatrix44();
    const model: LAppModel = this._models.at(0);

    if (model.getModel()) {
      if (model.getModel().getCanvasWidth() > 1.0 && width < height) {
        // 横に長いモデルを縦長ウィンドウに表示する際モデルの横サイズでscaleを算出する
        model.getModelMatrix().setWidth(2.0);
        projection.scale(1.0, width / height);
      } else {
        projection.scale(height / width, 1.0);
      }

      // 必要があればここで乗算
      if (this._viewMatrix != null) {
        projection.multiplyByMatrix(this._viewMatrix);
      }
    }

    // Process queued actions when not currently processing
    if (!this._isProcessingAction && this._actionQueue.length > 0) {
      this.processNextAction();
    }

    model.update();
    model.draw(projection); // 参照渡しなのでprojectionは変質する。
  }

  /**
   * 次のシーンに切りかえる
   * サンプルアプリケーションではモデルセットの切り替えを行う。
   */
  public nextScene(): void {
    const no: number = (this._sceneIndex + 1) % LAppDefine.ModelDirSize;
    this.changeScene(no);
  }

  /**
   * シーンを切り替える
   * サンプルアプリケーションではモデルセットの切り替えを行う。
   * @param index
   */
  private changeScene(index: number): void {
    this._sceneIndex = index;

    if (LAppDefine.DebugLogEnable) {
      LAppPal.printMessage(`[APP]model index: ${this._sceneIndex}`);
    }

    // ModelDir[]に保持したディレクトリ名から
    // model3.jsonのパスを決定する。
    // ディレクトリ名とmodel3.jsonの名前を一致させておくこと。
    const model: string = LAppDefine.ModelDir[index];
    const modelPath: string = LAppDefine.ResourcesPath + model + '/';
    let modelJsonName: string = LAppDefine.ModelDir[index];
    modelJsonName += '.model3.json';

    this.releaseAllModel();
    const instance = new LAppModel();
    instance.setSubdelegate(this._subdelegate);
    instance.loadAssets(modelPath, modelJsonName);
    this._models.pushBack(instance);
  }

  public setViewMatrix(m: CubismMatrix44) {
    for (let i = 0; i < 16; i++) {
      this._viewMatrix.getArray()[i] = m.getArray()[i];
    }
  }

  /**
   * モデルの追加
   */
  public addModel(sceneIndex: number = 0): void {
    this._sceneIndex = sceneIndex;
    this.changeScene(this._sceneIndex);
  }

  /**
   * コンストラクタ
   */
  public constructor() {
    this._subdelegate = null;
    this._viewMatrix = new CubismMatrix44();
    this._models = new csmVector<LAppModel>();
    this._sceneIndex = 0;
    this._actionClient = new ActionClient();
  }

  /**
   * 解放する。
   */
  public release(): void {
    this._actionClient.stopPolling();
  }

  /**
   * 初期化する。
   * @param subdelegate
   */
  public initialize(subdelegate: LAppSubdelegate): void {
    this._subdelegate = subdelegate;
    this.changeScene(this._sceneIndex);
    
    // Start polling for actions from the server
    this._actionClient.startPolling((action: Action) => {
      this.queueAction(action);
    });
  }

  /**
   * Add an action to the queue
   * @param action The action to queue
   */
  private queueAction(action: Action): void {
    this._actionQueue.push(action);
    console.log(`[LAppLive2DManager] Queued action: ${JSON.stringify(action)}. Queue size: ${this._actionQueue.length}`);
  }

  /**
   * Process the next action in the queue
   */
  private processNextAction(): void {
    if (this._actionQueue.length === 0 || this._isProcessingAction) return;

    const action = this._actionQueue.shift();
    console.log(`[LAppLive2DManager] Processing queued action: ${JSON.stringify(action)}. Remaining: ${this._actionQueue.length}`);
    
    this._isProcessingAction = true;
    this.processAction(action);
  }

  /**
   * Process an action from the server
   * @param action The action to process
   */
  private processAction(action: Action): void {
    const model = this._models.at(0);
    if (!model) return;

    console.log(`[LAppLive2DManager] Processing action: ${JSON.stringify(action)}`);

    switch (action.type) {
      case 'motion':
        if (action.group && action.index !== undefined) {
          model.startMotion(
            action.group,
            action.index,
            LAppDefine.PriorityNormal,
            this.finishedMotion,
            this.beganMotion
          );
        } else if (action.group) {
          model.startRandomMotion(
            action.group,
            LAppDefine.PriorityNormal,
            this.finishedMotion,
            this.beganMotion
          );
        }
        break;
      
      case 'expression':
        if (action.name) {
          model.setExpression(action.name);
        } else {
          model.setRandomExpression();
        }
        // Expressions change immediately, so we can process next action
        setTimeout(() => {
          this._isProcessingAction = false;
        }, 500); // Give 500ms for expression to be visible
        break;
      
      case 'tap':
        if (action.x !== undefined && action.y !== undefined) {
          this.onTap(action.x, action.y);
        }
        // Tap might trigger a motion, so wait for it to complete
        // If no motion is triggered, reset after a delay
        setTimeout(() => {
          if (this._isProcessingAction) {
            this._isProcessingAction = false;
          }
        }, 1000);
        break;
    }
  }

  /**
   * 自身が所属するSubdelegate
   */
  private _subdelegate: LAppSubdelegate;

  _viewMatrix: CubismMatrix44; // モデル描画に用いるview行列
  _models: csmVector<LAppModel>; // モデルインスタンスのコンテナ
  private _sceneIndex: number; // 表示するシーンのインデックス値
  private _actionClient: ActionClient; // Action server client

  // モーション再生開始のコールバック関数
  beganMotion = (self: ACubismMotion): void => {
    LAppPal.printMessage('Motion Began:');
    console.log(self);
  };
  // モーション再生終了のコールバック関数
  finishedMotion = (self: ACubismMotion): void => {
    LAppPal.printMessage('Motion Finished:');
    console.log(self);
    // Reset processing flag to allow next action
    this._isProcessingAction = false;
  };
}
