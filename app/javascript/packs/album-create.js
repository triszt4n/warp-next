const fileInput = document.querySelector("#fileinput")
const fileCountSpan = document.querySelector("#filecount")

if (typeof fileInput != "undefined" && fileInput != null) {
  fileInput.onchange = (e) => {
    if (typeof fileCountSpan != "undefined" && fileCountSpan != null) {
      fileCountSpan.innerHTML = fileInput.files.length
    }
  }
}
