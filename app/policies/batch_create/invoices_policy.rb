module BatchCreate
  class InvoicesPolicy < ApplicationPolicy
    def create?
      invoice_exists, room_number = record.invoice_already_exist?

      if invoice_exists
        raise Pundit::NotAuthorizedError,
              message: I18n.t("pundit.errors.batch_create.invoices_form.has_invoice_already_exist", room_number: room_number)
      end

      true
    end
  end
end
