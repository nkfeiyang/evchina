module DirectoryHelper
  def filter_Uri(new_var)
    url = '?'
    unless !new_var.empty? && params[new_var].empty?
      url = url + new_var
    end
  end
end
