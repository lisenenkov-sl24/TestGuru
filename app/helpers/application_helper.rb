module ApplicationHelper
  def authors
    "#{Time.current.strftime('%Y')} Лисененков Д.А."
  end

  def github_url(author, repo)
    link_to repo, "https://github.com/#{author}/#{repo}", target: '_blank'
  end
end
