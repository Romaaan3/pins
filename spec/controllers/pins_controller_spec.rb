require 'rails_helper'

describe PinsController do
  login_user

  it "should have a current_user" do
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
    expect(subject.current_user).to_not eq(nil)
  end

  describe 'GET #show' do
    it "assigns the requested pin to @pin" do
      pin = create(:pin)
      get :show, id: pin
      expect(assigns(:pin)).to eq pin
    end

    it "renders the :show template" do
      pin = create(:pin)
      get :show, id: pin
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before :each do
      user = User.create(
        email: 'qwe@qwe.com',
        encrypted_password: 123123123,
        )
    end
    it "assigns a new Pin to @pin" do
      get :new
      expect(assigns(:pin)).to be_a_new(Pin)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested pin to @pin" do
      pin = create(:pin)
      get :edit, id: pin
      expect(assigns(:pin)).to eq pin
    end

    it "renders the :edit template" do
      pin = create(:pin)
      get :edit, id: pin
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new pin in the database" do
        expect{
          post :create, pin: attributes_for(:pin)
        }.to change(Pin, :count).by(1)
      end

      it "redirects to pins#show" do
        post :create, pin: attributes_for(:pin)
        expect(response).to redirect_to pin_path(assigns[:pin])
      end
    end

    context "with invalid attributes" do
      it "doesn't save the new pin in the database" do
        expect{
          post :create,
            pin: attributes_for(:invalid_pin)
        }.to_not change(Pin, :count)
      end

      it "re-renders the :new template" do
        post :create,
          pin: attributes_for(:invalid_pin)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @pin = create(:pin,
        title: 'MyPin',
        description: 'Desc')
    end

    context "valid attributes" do
      it "locates the requested @pin" do
        patch :update, id: @pin, pin: attributes_for(:pin)
        expect(assigns(:pin)).to eq(@pin)
      end

      it "changes @pin's attributes" do
        patch :update, id: @pin,
          pin: attributes_for(:pin,
            title: 'MyUpdatedPin',
            description: 'UpdatedDesc')
          @pin.reload
          expect(@pin.title).to eq('MyUpdatedPin')
          expect(@pin.description).to eq('UpdatedDesc')
      end

      it "redirects to the updated pin" do
        patch :update, id: @pin, pin: attributes_for(:pin)
        expect(response).to redirect_to @pin
      end
    end

    context "with invalid attributes" do
      it "doesn't change the contact's attributes" do
        patch :update, id: @pin,
          pin: attributes_for(:pin,
            title: "Title",
            description: nil)
          @pin.reload
          expect(@pin.title).to_not eq('Title')
          expect(@pin.description).to eq('Desc')
      end

      it "re-renders the #edit template" do
        patch :update, id: @pin,
          pin: attributes_for(:invalid_pin)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @pin = create(:pin)
    end

    it "deletes the contact from the database" do
      expect{
        delete :destroy, id: @pin
      }.to change(Pin, :count).by(-1)
    end

    it "redirects to root_path" do
      delete :destroy, id: @pin
      expect(response).to redirect_to root_path
    end
  end
end




