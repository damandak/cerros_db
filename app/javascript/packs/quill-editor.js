const MAX_FILE_SIZE = 3000000

importImage = function (textEditor) {
	if (file.size > MAX_FILE_SIZE) {
	 alert("Only support attachment files upto size 1MB!")
	 return
	}

  const input = document.createElement('input');
  input.setAttribute('type', 'file');
  input.click();

  input.onchange = () => {
    const file = input.files[0];

    // Ensure only images are uploaded
    if (/^image\//.test(file.type)) {
      uploadImage(textEditor, file);
    } else {
      alert('Only images allowed');
    }
  };
};

var uploadImage = function (textEditor, file) {
  var fd = new FormData();
  fd.append('blob', file);

  var upload = new DirectUpload(file, '/rails/active_storage/direct_uploads')
  upload.create((error, blob) => {
    if (error) {
      console.log(error)
    } else {
      insertImage(
        textEditor,
        '/rails/active_storage/blobs/${blob.signed_id}/${blob.filename}'
      );
    }
  });
};

var insertImage = function (textEditor, fileUrl) {
  const range = textEditor.getSelection();
  textEditor.insertEmbed(range.index, 'image', fileUrl);
};