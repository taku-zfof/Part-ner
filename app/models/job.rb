class Job < ApplicationRecord
    geocoded_by :other_address
    after_validation :geocode, if: :other_address_changed? #住所が入ったら緯度経度を入れる

    belongs_to :user
    has_many :bookmarks, dependent: :destroy
    has_many :offers, dependent: :destroy

    has_one_attached :image
    
    validates :tytle, presence: true
    validates :job_type, presence: true
    validates :introduction, presence: true
    validates :postal_code, presence: true, format: {with: /\A\d{3}[-]\d{4}$|^\d{3}[-]\d{2}$|^\d{3}$|^\d{5}$|^\d{7}\z/} #半角数字７桁のみ。ハイフン有り無しok
    validates :prefecture_code, presence: true
    validates :other_address, presence: true
    validates :near_station, presence: true
    validates :near_station_line, presence: true
    validates :hourly_wage, presence: true ,format:{with: /\A[0-9]+\z/}#半角数字のみ
    validates :latitude, presence: true
    validates :longitude, presence: true


  #画像を表示させるメソッド。画像がない場合にはnoimageを表示させる。
  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage_job.png')
      image.attach(io: File.open(file_path), filename: 'noimage_job.jpg', content_type: 'image/png')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  # current_userにブックマークされているか確認するメソッド。ビューの表示分岐で使う
  def keeped_by?(user)
    bookmarks.exists?(user_id: user.id)
  end
  
  # current_userが送ったオファーが存在するか確認するメソッド。ビューの表示分岐で使う
  def offerd_by?(user)
    offers.exist?(user_id: user.id)
  end


   enum job_type: {
    飲食・フードサービス:0,営業・販売:1,旅行・レジャー・イベント:2,倉庫・物流・生産管理:3,警備・保安:4,
    経営・事業企画・人事・事務:5,マーケティング・広告・宣伝:6,保育士・教員・講師:7,ドライバー・引越し作業員:8,
    介護・福祉:9,医療・看護師・薬剤師:10,メディア・クリエイター:11,IT・Web・ゲームエンジニア:12,
    エンジニアリング・設計開発:13,整備・修理:14,清掃・美化:15,ビューティ・生活サービス:16,建設・土木・施工:17,
    製造・工場:18,金融・財務・会計:19,法務・法律:20,研究:21,農林漁業:22,
  }

   enum prefecture_code: {
     北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
     茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
     新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
     岐阜県:21,静岡県:22,愛知県:23,三重県:24,
     滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
     鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
     徳島県:36,香川県:37,愛媛県:38,高知県:39,
     福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
     沖縄県:47 }
end
