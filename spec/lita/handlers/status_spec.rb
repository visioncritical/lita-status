require 'spec_helper'

describe Lita::Handlers::Status, lita_handler: true do
  it { is_expected.to route_command('status set somestatus').to(:set) }
  it { is_expected.to route_command('status on behalf set some.user somepassword somestatus').to(:on_behalf_set) }
  it { is_expected.to route_command('status get').to(:get) }
  it { is_expected.to route_command('status get some.user').to(:get) }
  it { is_expected.to route_command('statuses').to(:statuses) }
  it { is_expected.to route_command('status remove').to(:remove) }
  it { is_expected.to route_command('status on behalf remove some.user password').to(:on_behalf_remove) }

  describe 'setting a status' do
    it 'should be successful' do
      grimey = Lita::User.create(123, name: 'Frank Grimes')
      send_command('status set just eating my lobster', as: grimey)
      expect(replies.last).to eq('Frank Grimes has a new status.')
    end
  end

  describe 'getting a status' do
    describe 'for a user with a status' do
      it 'should return their status' do
        grimey = Lita::User.create(123, name: 'Frank Grimes', mention_name: 'grimey')
        send_command('status set just eating my lobster', as: grimey)
        send_command('status get grimey', as: grimey)
        expect(replies.last).to eq('Frank Grimes: just eating my lobster')
      end
    end

    describe 'for a user without a status' do
      it 'should inform they don\'t have one' do
        grimey = Lita::User.create(123, name: 'Frank Grimes', mention_name: 'grimey')
        send_command('status get grimey', as: grimey)
        expect(replies.last).to eq('Frank Grimes has no status.')
      end      
    end

    describe 'for a user that doesn\'t exist' do
      it 'should inform that no user was found' do
        send_command('status get grimey')
        expect(replies.last).to eq('Could not find a user with the name grimey.')
      end      
    end
  end

  describe 'getting all statuses' do
    it 'should return everything' do
      grimey = Lita::User.create(123, name: 'Frank Grimes', mention_name: 'grimey')
      homer = Lita::User.create(124, name: 'Homer Simpson', mention_name: 'homer')
      burns = Lita::User.create(125, name: 'Montgomery Burns', mention_name: 'burns')
      send_command('status set just eating my lobster', as: grimey)
      send_command('status set peeing on the seat', as: homer)
      send_command('status set releasing the hounds', as: burns)
      send_command('statuses')
      replies.shift(3)
      expect(replies.grep(/Frank Grimes: just eating my lobster/).first).to eq('Frank Grimes: just eating my lobster')
      expect(replies.grep(/Homer Simpson: peeing on the seat/).first).to eq('Homer Simpson: peeing on the seat')
      expect(replies.grep(/Montgomery Burns: releasing the hounds/).first).to eq('Montgomery Burns: releasing the hounds')
    end
  end

  describe 'with a password' do
    describe 'setting a status on behalf' do
      it 'should be successful' do
        grimey = Lita::User.create(123, name: 'Frank Grimes', mention_name: 'grimey')
        send_command('status password set orphan', as: grimey)
        send_command('status on behalf set grimey orphan going to space, brb', as: grimey)
        expect(replies.last).to eq('Frank Grimes has a new status.')
      end
    end

    describe 'removing a status on behalf' do
      it 'should be successful' do
        grimey = Lita::User.create(123, name: 'Frank Grimes', mention_name: 'grimey')
        send_command('status password set orphan', as: grimey)
        send_command('status on behalf remove grimey orphan', as: grimey)
        expect(replies.last).to eq('Status removed for Frank Grimes.')
      end
    end
  end

  describe 'without a password' do
    describe 'setting a status on behalf' do
      it 'should fail' do
        grimey = Lita::User.create(123, name: 'Frank Grimes', mention_name: 'grimey')
        send_command('status on behalf set grimey orphan going to space, brb', as: grimey)
        expect(replies.last).to eq('Failed to set status. There\'s no password set for Frank Grimes.')
      end
    end

    describe 'removing a status on behalf' do
      it 'should fail' do
        grimey = Lita::User.create(123, name: 'Frank Grimes', mention_name: 'grimey')
        send_command('status on behalf remove grimey orphan', as: grimey)
        expect(replies.last).to eq('Failed to remove status. There\'s no password set for Frank Grimes.')
      end
    end
  end

  describe 'setting a password' do
    it 'should be successful' do
      grimey = Lita::User.create(123, name: 'Frank Grimes', mention_name: 'grimey')
      send_command('status password set orphan', as: grimey)
      expect(replies.last).to eq('Password successfully set for Frank Grimes.')
    end
  end

  describe 'removing a password' do
    it 'should be successful' do
      grimey = Lita::User.create(123, name: 'Frank Grimes', mention_name: 'grimey')
      send_command('status password remove', as: grimey)
      expect(replies.last).to eq('Password successfully removed for Frank Grimes.')
    end
  end

end
