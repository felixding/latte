module PagesHelper
  def write_legacy_paths text
    text.gsub("dingyu.me", "dingyu.me:10086")
  end
end
