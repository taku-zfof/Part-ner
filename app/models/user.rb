class User < ApplicationRecord

  has_many :jobs, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :messages, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  #バリデーション
  validates :name, length: { minimum: 1, maximum: 30 }
  validates :sex, presence: true
  validates :age, presence: true
  validates :prefecture, presence: true
  validates :introduction, length: {maximum: 500}

  #都道府県コード→都道府県名
  enum prefecture: {
     北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
     茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
     新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
     岐阜県:21,静岡県:22,愛知県:23,三重県:24,
     滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
     鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
     徳島県:36,香川県:37,愛媛県:38,高知県:39,
     福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
     沖縄県:47 }

  enum sex: {
    男性:1,女性:2,その他:3
  }

  #画像を表示させるメソッド。画像がない場合にはnoimageを表示させる。
  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.png')
      image.attach(io: File.open(file_path), filename: 'noimage.png', content_type: 'image/png')
    end
    #指定サイズにリサイズ、中心を基準点にして、指定サイズに切り抜く。
    image.variant(resize: "#{width}x#{height}^", gravity: :center, crop: "#{width}x#{height}+0+0").processed
  end


  before_create :set_account_name #ユーザー作成時に以下のアクション
  # アカウント名が空か、同じアカウント名のユーザーが存在する時にランダムな文字列を代入する
    def set_account_name
      while self.account_name.blank? || User.find_by(account_name: self.account_name).present? do
        self.account_name = SecureRandom.base36
      end
    end
    def to_param
       account_name
    end

  #ゲストユーザーの設定
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.age = 25
      user.sex = 3
      user.prefecture = 13
      user.introduction = "ゲストユーザーです！よろしくお願いします！"
    end
  end

end
