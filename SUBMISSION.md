Submission for Applied AI Hackathon by Cognition
https://partiful.com/e/hUU7NyM8EjHLxjMuJROs

---

Notification Utility Tool

---

This is an overengineered Claude Code hook to notify when Claude Code requires the developer's attention, with anime avatars and voicelines.

---

When coding agents work on longer tasks I usually keep them running.
However, I need to be notified when they are done or when they need my attention.
This is an overengineered Claude Code hook to notify when Claude Code requires the developer's attention, with anime avatars and voicelines.

To use this in any Claude Code instance, simply add this to your Claude Code hook (https://github.com/tonghuikang/claude-code-live-2d/blob/master/.claude/settings.json).

This tool is designed to be platform-agnostic - when Windsurf and Cognition have hook functionality we will adapt this code to notify as well.

Technologies used

* Windsurf - We used Windsurf to build a simple server to enqueue and retrieve messages
* Anthropic - We used Claude Code to test whether the Claude Code hooks work. Anthropic Sonnet 4 and Opus 4 were used to code
* Modal - The server to enqueue and retrieve messages is hosted on Modal
* OpenAI - The voices are prompted with OpenAI realtime

Contributions

* Hui Kang prototyped the idea three weeks ago, Han Lee deployed the app to Vercel, implemented CI/CD and enabled multi-user usage.
* Han Lee needed to leave early today, but he contributed most of the code today.
* The base code and character animation are from Live2D https://www.live2d.com/en/learn/sample/

Future work

* Avoid hard-coding voicelines and inform the user based on what is changed
* Train a model to natively produce the animated movements and voicelines, similar what humans are currently

---
