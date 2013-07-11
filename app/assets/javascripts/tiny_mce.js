 function inicializaTinyMCE() {
  tinyMCE.init({
    mode : "textareas",
    theme: "advanced",
    plugins: "print,fullscreen",
    // Theme options
    theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,fontsizeselect,forecolor,backcolor,|,outdent,indent,|,bullist,numlist,|,undo,redo,|,print,fullscreen",
    theme_advanced_buttons2 : "",
    theme_advanced_buttons3 : "",
    theme_advanced_buttons4 : "",
    theme_advanced_toolbar_location : "top",
    theme_advanced_toolbar_align : "left",
    tab_focus: ':prev,:next'
  });
}