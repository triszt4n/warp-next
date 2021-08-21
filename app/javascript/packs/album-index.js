const searchBar = document.querySelector("#searchBar")
const albumColumns = document.querySelectorAll("#albumColumn")

searchBar.addEventListener('keyup', () => {
    const filter = searchBar.value.toUpperCase()
    // Loop through all list items, and hide those who don't match the search query
    albumColumns.forEach((albumColumn, index) => {
        const title = albumColumn.dataset.title
        if (title.toUpperCase().indexOf(filter) > -1) {
            albumColumn.style.display = ""
        } else {
            albumColumn.style.display = "none"
        }
    })
})
