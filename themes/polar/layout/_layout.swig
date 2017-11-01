<!DOCTYPE html>
<html lang="{{ connfig.language }}">
  <head>
    {% include '_partial/head.swig' %}
    <title>{% block title %}{% endblock %}</title>
  </head>

  <body>
    <div id="page">
      <header id="masthead">
        {%- include '_partial/header.swig' %}
      </header>
      <div id="content">
        {% block content %}{% endblock %}
      </div>

      <footer id="colophon">
        {%- include '_partial/footer.swig' %}
      </footer>

      <div class="back-to-top" id="back-to-top">
        <i class="iconfont icon-up"></i>
      </div>
    </div>
    <script type="text/javascript" async
      src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
    </script>
    <script type="text/javascript">
  $(document).ready(function(){
    $("code").map(function(){
      match = /^\$(.*)\$$/.exec($(this).html());
      if (match){
        //$(this).after("<span class=mathjax_inline>" + match + "</span>");
        //$(this).hide();
        $(this).replaceWith("<span class=hpl_mathjax_inline>" + $(this).html() + "</span>");
        MathJax.Hub.Queue(["Typeset",MathJax.Hub,$(this).get(0)]);
      }
    });
  });
  </script>
    {% include '_script/comments.swig' %}
    {% include '_script/libs.swig' %}
    {% include '_script/theme.swig' %}
  </body>
</html>
