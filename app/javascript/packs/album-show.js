import PhotoSwipe from 'photoswipe'
import PhotoSwipeUI_Default from 'photoswipe/dist/photoswipe-ui-default'
import 'photoswipe/dist/photoswipe.css'
import 'photoswipe/dist/default-skin/default-skin.css'

const albumImgs = document.querySelectorAll('.album-image')
const pswpElement = document.querySelector('.pswp')

const openPswp = (index) => {
  const options = {
    clickToCloseNonZoomable: false,
    closeOnScroll: false,
    history: false,
    index,
    getThumbBoundsFn: (index) => {
      // find thumbnail element
      const thumbnail = albumImgs[index]
      // get window scroll Y
      const pageYScroll = window.pageYOffset || document.documentElement.scrollTop
      // optionally get horizontal scroll
      // get position of element relative to viewport
      const rect = thumbnail.getBoundingClientRect()
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


albumImgs.forEach((card, index) => {
  card.addEventListener('click', (e) => {
    openPswp(index)
  })
})

const content = document.querySelector("#content")
const masonry = new Masonry(content, {
  percentPosition: true
})
imagesLoaded(content, (instance) => {
  masonry.layout();
})

class BulmaModal {
	constructor(selector) {
		this.elem = document.querySelector(selector)
		this.close_data()
	}
	
	show() {
		this.elem.classList.toggle('is-active')
		this.on_show()
	}
	
	close() {
		this.elem.classList.toggle('is-active')
		this.on_close()
	}
	
	close_data() {
		const modalClose = this.elem.querySelectorAll("[data-bulma-modal='close'], .modal-background")
		const that = this
		modalClose.forEach((e) => {
			e.addEventListener("click", () => {
				that.elem.classList.toggle('is-active')
				const event = new Event('modal:close')
				that.elem.dispatchEvent(event);
			})
		})
	}
	
	on_show() {
		var event = new Event('modal:show')
		this.elem.dispatchEvent(event)
	}
	
	on_close() {
		var event = new Event('modal:close')
		this.elem.dispatchEvent(event)
	}
	
	addEventListener(event, callback) {
		this.elem.addEventListener(event, callback)
	}
}

const btn = document.querySelector("#modalButton")
const mdl = new BulmaModal("#myModal")
const closeBtns = document.querySelectorAll("#closeButton")

btn.addEventListener("click", function () {
	mdl.show()
})

closeBtns.forEach((btn) => {
	btn.addEventListener("click", function () {
		mdl.close()
	})
})

mdl.addEventListener('modal:show', function() {
	console.log("opened")
})

mdl.addEventListener("modal:close", function() {
	console.log("closed")
})

const fileInput = document.querySelector("#fileinput")
const fileCountSpan = document.querySelector("#filecount")

if (typeof fileInput != "undefined" && fileInput != null) {
  fileInput.onchange = (e) => {
    if (typeof fileCountSpan != "undefined" && fileCountSpan != null) {
      fileCountSpan.innerHTML = fileInput.files.length
    }
  }
}

const clipboardBtns = document.querySelectorAll("#clipboardButton")

clipboardBtns.forEach((btn) => {
	btn.addEventListener("click", (e) => {
		navigator.clipboard.writeText(`${window.location.origin}${btn.dataset.url}`)
	})
})
