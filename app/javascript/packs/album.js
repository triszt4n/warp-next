import PhotoSwipe from 'photoswipe'
import PhotoSwipeUI_Default from 'photoswipe/dist/photoswipe-ui-default'
import 'photoswipe/dist/photoswipe.css'
import 'photoswipe/dist/default-skin/default-skin.css'

const openPswp = (index) => {
  const pswpElement = document.querySelectorAll('.pswp')[0]

  const options = {
    clickToCloseNonZoomable: false,
    closeOnScroll: false,
    history: false,
    index,
    getThumbBoundsFn: function(index) {
      // find thumbnail element
      var thumbnail = document.querySelectorAll('.album-image')[index]
      // get window scroll Y
      var pageYScroll = window.pageYOffset || document.documentElement.scrollTop
      // optionally get horizontal scroll
      // get position of element relative to viewport
      var rect = thumbnail.getBoundingClientRect()
      return {
        x: rect.left, 
        y: rect.top + pageYScroll, 
        w: rect.width
      }
    }
  }

  // Initializes and opens PhotoSwipe
  const gallery = new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, images, options)
  gallery.init()
}

const albumImgs = document.querySelectorAll('.album-image')
albumImgs.forEach((card, index) => {
  card.addEventListener('click', (e) => {
    openPswp(index)
  })
})

var content = document.querySelector("#content")
var masonry = new Masonry(content, {
  percentPosition: true
})
imagesLoaded(content, (instance) => {
  masonry.layout();
})
