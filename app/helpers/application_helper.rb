module ApplicationHelper
  # 現在いるアクションに応じてサイドバーをアクティブにするヘルパー
  def active_if(path)
    path == controller_path ? 'active' : ''
  end
end
