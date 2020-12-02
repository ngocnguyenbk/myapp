class ContractsController < ApplicationController
  before_action :contract, only: [:show, :destroy]

  def index
    @presenter = ContractsPresenter.new(params)

    respond_to do |format|
      format.html
      format.json do
        render json: ContractListSerializer.new(data: @presenter.contracts).generate
      end
    end
  end

  def create
    @form = ContractsForm.new(contract_params)
    if @form.save
      flash[:success] = t(".success")
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity, errors: @form.errors }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json do
        render json: {
          contract: ContractSerializer.new(contract),
          detail: DetailContractSerializer.new(contract)
        }
      end
    end
  end

  def destroy
    @form = ContractsForm.new
    @form.record = @contract
    @form.destroy
  end

  private

  def contract_params
    params.require(:contract).permit(:holder_id, :room_id, :room_price, :deposited_money, :started_date, :ended_date)
  end

  def contract
    @contract = Contract.find(params[:id])
  end
end
