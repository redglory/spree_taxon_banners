class AddAttachmentBannerToSpreeTaxons < ActiveRecord::Migration
  def change
    add_attachment :spree_taxons, :banner
  end
end
