module ApplicationHelper
  # 現在いるコントローラに応じてサイドバーをアクティブにするヘルパー
  def active_if(path)
    path == controller_path ? 'active' : ''
  end

  #deviseのフラッシュメッセージにalertのスタイルを適用
  def bootstrap_alert(key)
    case key
    when "alert"
      "warning"
    when "notice"
      "success"
    when "error"
      "danger"
    end
  end
end
