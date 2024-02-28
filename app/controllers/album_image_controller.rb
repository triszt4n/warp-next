class AlbumImageController < ApplicationController
  before_action :set_image

  def show
    http_cache_forever public: true do
      content_headers_from @image.file.blob
      stream @image.file.blob
    end
  end

  private

  def set_image
    @image = AlbumImage.friendly.find(params[:id])
    authorize @image
  end

  def content_headers_from(blob)
    response.headers['Content-Type']        = blob.content_type_for_serving
    response.headers['Content-Disposition'] = ActionDispatch::Http::ContentDisposition.format \
      disposition: blob.forced_disposition_for_serving || params[:disposition] || 'inline',
      filename: blob.filename.sanitized
  end

  def stream(blob)
    blob.download do |chunk|
      response.stream.write chunk
    end
  ensure
    response.stream.close
  end
end
