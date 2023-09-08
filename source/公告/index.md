---
title: 公告
date: 2023-09-08 11:59:30
categories:
- 公告
---

<ul>
{% for post in site.categories['技术'] %}
  <li><a href="{{ post.url }}">{{ post.title }}</a></li>
{% endfor %}
</ul>
