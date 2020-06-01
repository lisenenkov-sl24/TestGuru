module ApplicationHelper
  def current_year
    Time.current.strftime('%Y')
  end

  def authors
    'Лисененков Д.А.'
  end

  def login_info(type)
    t("welcome.#{type}", user: link_to(current_user.name, edit_user_registration_path)).html_safe
  end

  def github_url(author, repo)
    link_to repo, "https://github.com/#{author}/#{repo}", target: '_blank'
  end
end
