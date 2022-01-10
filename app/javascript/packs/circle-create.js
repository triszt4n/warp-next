const fileInput = document.querySelector("#fileinput")
const fileName = document.querySelector("#filename")

if (typeof fileInput != "undefined" && fileInput != null) {
  fileInput.onchange = (e) => {
    if (typeof fileName != "undefined" && fileName != null) {
      fileName.textContent = fileInput.files[0].name
    }
  }
}
