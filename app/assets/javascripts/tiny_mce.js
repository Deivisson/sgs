 function inicializaTinyMCE() {
  tinymce.init({
      selector: "textarea",
      menubar: false,
      plugins: [
          "fullscreen","textcolor","print preview"
      ],
      toolbar1: "undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | print preview media | forecolor backcolor| fullscreen"
  });
}