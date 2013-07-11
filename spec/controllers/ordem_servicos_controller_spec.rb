require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe OrdemServicosController do

  def mock_ordem_servico(stubs={})
    @mock_ordem_servico ||= mock_model(OrdemServico, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all ordem_servicos as @ordem_servicos" do
      OrdemServico.stub(:all) { [mock_ordem_servico] }
      get :index
      assigns(:ordem_servicos).should eq([mock_ordem_servico])
    end
  end

  describe "GET show" do
    it "assigns the requested ordem_servico as @ordem_servico" do
      OrdemServico.stub(:find).with("37") { mock_ordem_servico }
      get :show, :id => "37"
      assigns(:ordem_servico).should be(mock_ordem_servico)
    end
  end

  describe "GET new" do
    it "assigns a new ordem_servico as @ordem_servico" do
      OrdemServico.stub(:new) { mock_ordem_servico }
      get :new
      assigns(:ordem_servico).should be(mock_ordem_servico)
    end
  end

  describe "GET edit" do
    it "assigns the requested ordem_servico as @ordem_servico" do
      OrdemServico.stub(:find).with("37") { mock_ordem_servico }
      get :edit, :id => "37"
      assigns(:ordem_servico).should be(mock_ordem_servico)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created ordem_servico as @ordem_servico" do
        OrdemServico.stub(:new).with({'these' => 'params'}) { mock_ordem_servico(:save => true) }
        post :create, :ordem_servico => {'these' => 'params'}
        assigns(:ordem_servico).should be(mock_ordem_servico)
      end

      it "redirects to the created ordem_servico" do
        OrdemServico.stub(:new) { mock_ordem_servico(:save => true) }
        post :create, :ordem_servico => {}
        response.should redirect_to(ordem_servico_url(mock_ordem_servico))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ordem_servico as @ordem_servico" do
        OrdemServico.stub(:new).with({'these' => 'params'}) { mock_ordem_servico(:save => false) }
        post :create, :ordem_servico => {'these' => 'params'}
        assigns(:ordem_servico).should be(mock_ordem_servico)
      end

      it "re-renders the 'new' template" do
        OrdemServico.stub(:new) { mock_ordem_servico(:save => false) }
        post :create, :ordem_servico => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ordem_servico" do
        OrdemServico.stub(:find).with("37") { mock_ordem_servico }
        mock_ordem_servico.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ordem_servico => {'these' => 'params'}
      end

      it "assigns the requested ordem_servico as @ordem_servico" do
        OrdemServico.stub(:find) { mock_ordem_servico(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:ordem_servico).should be(mock_ordem_servico)
      end

      it "redirects to the ordem_servico" do
        OrdemServico.stub(:find) { mock_ordem_servico(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(ordem_servico_url(mock_ordem_servico))
      end
    end

    describe "with invalid params" do
      it "assigns the ordem_servico as @ordem_servico" do
        OrdemServico.stub(:find) { mock_ordem_servico(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:ordem_servico).should be(mock_ordem_servico)
      end

      it "re-renders the 'edit' template" do
        OrdemServico.stub(:find) { mock_ordem_servico(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested ordem_servico" do
      OrdemServico.stub(:find).with("37") { mock_ordem_servico }
      mock_ordem_servico.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the ordem_servicos list" do
      OrdemServico.stub(:find) { mock_ordem_servico }
      delete :destroy, :id => "1"
      response.should redirect_to(ordem_servicos_url)
    end
  end

end
