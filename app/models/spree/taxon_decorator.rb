Spree::Taxon.class_eval do
  
  validates_associated :banner
  has_one :banner, as: :viewable, dependent: :destroy, class_name: 'Spree::TaxonBanner'

end