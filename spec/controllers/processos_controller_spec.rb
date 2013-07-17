require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe ProcessosController do

  def mock_processo(stubs={})
    @mock_processo ||= mock_model(Processo, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all processos as @processos" do
      Processo.stub(:all) { [mock_processo] }
      get :index
      assigns(:processos).should eq([mock_processo])
    end
  end

  describe "GET show" do
    it "assigns the requested processo as @processo" do
      Processo.stub(:find).with("37") { mock_processo }
      get :show, :id => "37"
      assigns(:processo).should be(mock_processo)
    end
  end

  describe "GET new" do
    it "assigns a new processo as @processo" do
      Processo.stub(:new) { mock_processo }
      get :new
      assigns(:processo).should be(mock_processo)
    end
  end

  describe "GET edit" do
    it "assigns the requested processo as @processo" do
      Processo.stub(:find).with("37") { mock_processo }
      get :edit, :id => "37"
      assigns(:processo).should be(mock_processo)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created processo as @processo" do
        Processo.stub(:new).with({'these' => 'params'}) { mock_processo(:save => true) }
        post :create, :processo => {'these' => 'params'}
        assigns(:processo).should be(mock_processo)
      end

      it "redirects to the created processo" do
        Processo.stub(:new) { mock_processo(:save => true) }
        post :create, :processo => {}
        response.should redirect_to(processo_url(mock_processo))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved processo as @processo" do
        Processo.stub(:new).with({'these' => 'params'}) { mock_processo(:save => false) }
        post :create, :processo => {'these' => 'params'}
        assigns(:processo).should be(mock_processo)
      end

      it "re-renders the 'new' template" do
        Processo.stub(:new) { mock_processo(:save => false) }
        post :create, :processo => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested processo" do
        Processo.stub(:find).with("37") { mock_processo }
        mock_processo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :processo => {'these' => 'params'}
      end

      it "assigns the requested processo as @processo" do
        Processo.stub(:find) { mock_processo(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:processo).should be(mock_processo)
      end

      it "redirects to the processo" do
        Processo.stub(:find) { mock_processo(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(processo_url(mock_processo))
      end
    end

    describe "with invalid params" do
      it "assigns the processo as @processo" do
        Processo.stub(:find) { mock_processo(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:processo).should be(mock_processo)
      end

      it "re-renders the 'edit' template" do
        Processo.stub(:find) { mock_processo(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested processo" do
      Processo.stub(:find).with("37") { mock_processo }
      mock_processo.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the processos list" do
      Processo.stub(:find) { mock_processo }
      delete :destroy, :id => "1"
      response.should redirect_to(processos_url)
    end
  end

end