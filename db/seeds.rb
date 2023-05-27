# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

#女性ユーザーのサンプル
100.times do |n|
  for num in 9..16 do
    user = User.create!(
      name: Gimei.female.first.katakana,
      email: Faker::Internet.email,
      password: 'password',
      sex: 2,
      age: Faker::Number.between(from: 18, to: 40),
      prefecture: Faker::Number.between(from: 1, to: 47),
      introduction: "こんにちは。見に来てくれてありがとうございます！でも残念ながら私はサンプルのユーザーなのでお話はできません。ごめんなさい！",
      account_name: SecureRandom.base36
      )
    user.image.attach(io: File.open(Rails.root.join("db/images/sample_user (#{num}).jpg")),filename: "sample_user(#{num}).jpg")
    p "#{user.name}が作成できました"

     3.times do |n|
      job = Job.create!(
        user_id: user.id,
        tytle: Faker::Company.name + "のバイト",
        introduction: "【この情報はサンプルです】とてもやりがいのあるバイトです。私たちは、前向きでやる気のある人を探し、教育とトレーニングを通じて、スキルや知識を身につけることができる素晴らしい機会を提供しています。この仕事には短期間のコミュニケーション能力やプレゼンテーション力など、あらゆるスキルが求められますが、それは将来のキャリアにおいて役立つことは言うまでもありません。私たちのアルバイトは、業界でも最高のキャリアアップチャンスを提供し、社会的責任を果たす立派な仕事だと考えています。",
        postal_code: Faker::Address.zip,
        prefecture_code: user.prefecture,
        other_address: Gimei.address.city.kanji + Gimei.town.kanji,
        near_station: "",
        near_station_line: "",
        hourly_wage: (Faker::Number.between(from: 9, to: 17).to_s + "00").to_i,
        job_type: Faker::Number.between(from: 1, to: 22),
        rondom_id: SecureRandom.base36
        )

        jobnum = Faker::Number.between(from: 1, to: 18)
        p job.latitude
        p job.longitude

        job.addStation
      job.image.attach(io: File.open(Rails.root.join("db/images/sample_job (#{jobnum}).jpeg")),filename: "sample_job(#{jobnum}).jpeg")
      p "#{job.tytle}が作成できました"
    end
  end
end

#男性ユーザーのサンプル
100.times do |n|
  for num in 1..8 do
    user = User.create!(
      name: Gimei.male.first.katakana,
      email: Faker::Internet.email,
      password: 'password',
      sex: 1,
      age: Faker::Number.between(from: 18, to: 40),
      prefecture: Faker::Number.between(from: 1, to: 47),
      introduction: "こんにちは。見に来てくれてありがとうございます！でも残念ながら私はサンプルのユーザーなのでお話はできません。ごめんなさい！",
      account_name: SecureRandom.base36
      )
    user.image.attach(io: File.open(Rails.root.join("db/images/sample_user (#{num}).jpg")),filename: "sample_user(#{num}).jpg")
    p "#{user.name}が作成できました"

    3.times do |n|
      job = Job.create!(
        user_id: user.id,
        tytle: Faker::Company.name + "のバイト",
        introduction: "【この情報はサンプルです】とてもやりがいのあるバイトです。私たちは、前向きでやる気のある人を探し、教育とトレーニングを通じて、スキルや知識を身につけることができる素晴らしい機会を提供しています。この仕事には短期間のコミュニケーション能力やプレゼンテーション力など、あらゆるスキルが求められますが、それは将来のキャリアにおいて役立つことは言うまでもありません。私たちのアルバイトは、業界でも最高のキャリアアップチャンスを提供し、社会的責任を果たす立派な仕事だと考えています。",
        postal_code: Faker::Address.zip,
        prefecture_code: user.prefecture,
        other_address: Gimei.address.city.kanji + Gimei.town.kanji,
        near_station: "",
        near_station_line: "",
        hourly_wage: (Faker::Number.between(from: 9, to: 17).to_s + "00").to_i,
        job_type: Faker::Number.between(from: 1, to: 22),
        rondom_id: SecureRandom.base36
        )

        jobnum = Faker::Number.between(from: 1, to: 18)
        p job.latitude
        p job.longitude

        job.addStation
      job.image.attach(io: File.open(Rails.root.join("db/images/sample_job (#{jobnum}).jpeg")),filename: "sample_job(#{jobnum}).jpeg")
      p "#{job.tytle}が作成できました"
    end
  end
end