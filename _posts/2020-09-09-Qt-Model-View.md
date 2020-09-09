---
layout: post
title:  "Overview of the Qt Model-View paradigm"
---

# Welcome

**Hello world**, this is my first Jekyll blog post.

I hope you like it!

{% graphviz %}
digraph {
  node [shape=circle, style=filled];
  S [fillcolor=green];
  A [fillcolor=yellow];
  B [fillcolor=yellow];
  C [fillcolor=yellow];
  D [shape=doublecircle, fillcolor=green];
  S -> A [label=a];
  S -> B [label=b];
  A -> D [label=c];
  B -> D [label=d];
}
{% endgraphviz %}

# References
[Official Qt Model/View Tutorial](https://doc.qt.io/qt-5/modelview.html)