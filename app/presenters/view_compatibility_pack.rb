module ViewCompatibilityPack
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper

  def url_helpers
    Rails.application.routes.url_helpers
  end
end
