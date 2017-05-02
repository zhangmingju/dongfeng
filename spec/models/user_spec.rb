require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe '#email' do 
    context '有效的地址' do 
      addresses = %w( abc@qq.com www@xyz.com )
      addresses.each do |address|
        let(:user) { build(:user, email: address) }
        it { expect(user.valid?).to eq true }
      end
    end

    context '空' do 
      let(:user) { build(:user, email: '') }
      it { expect(user.valid?).to eq false }
    end

    context '无效的地址' do 
      let(:user) { build(:user, email: 'sss') }
      it { expect(user.valid?).to eq false }
    end

    context '重复的地址' do 
      let(:same_email) { build(:user, email: user.email) }
      it { expect(same_email.valid?).to eq false }
    end
  end

  describe '#nick_name' do 
    context '空' do 
      let(:user) { build(:user, nick_name: '')}
      it { expect(user.valid?).to eq false}
    end

    context '有效' do 
      it { expect(user.valid?).to eq true }
    end
  end

  describe '#phone_number' do 
    context '空' do 
      let(:user) { build(:user, phone_number: '')}
      it { expect(user.valid?).to eq false}
    end

    context '有效' do 
      it { expect(user.valid?).to eq true }
    end

    context '重复的电话' do 
      let(:same_phone_number) { build(:user, phone_number: user.phone_number)}
      it { expect(same_phone_number.valid?).to eq false}
    end
  end

  describe '#role' do 
    it 'default role' do
      expect(user).to have_role("普通用户")
    end

    it 'admin role' do
      user.add_role(:admin)
      LoggerApp.info("  have_role: #{have_role(:admin)}")
      expect(user).to have_role(:admin)
    end
  end
end