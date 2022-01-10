class SecureBlobsController < ActiveStorage::BaseController
  include ActiveStorage::SetBlob
  include ActiveStorage::SetHeaders
  before_action :authenticate_request

  def show
    http_cache_forever public: true do
      set_content_headers_from @blob
      stream @blob
    end
  end

  private

  def authenticate_request
    if current_user.nil? head :forbidden
    end
  end

end
