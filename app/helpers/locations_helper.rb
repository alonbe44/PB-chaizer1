module LocationsHelper
  def locations_path(params = {})
    url_for(controller: 'locations', action: 'index', params: params)
  end
end