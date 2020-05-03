module ApplicationHelper
  def current_year
    Time.now.strftime('%Y')
  end

  def authors
    'Лисененков Д.А.'
  end

  def github_url(author, repo)
    link_to repo, "https://github.com/#{author}/#{repo}", target: '_blank'
  end
end
