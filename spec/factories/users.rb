FactoryGirl.define do 
  sequence :email do |n|
    "dongfeng#{n}@qq.com"
  end
  sequence :phone_number do |n|
    "1832118964".sub("#{n}",((n+1)%10).to_s)
  end
  factory :user, aliases: [:author] do 
    password "password"
    password_confirmation "password"
    # email { generate(:email) }
    email
    phone_number { generate(:phone_number) }
    nick_name "dongfeng"
  end
end