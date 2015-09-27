Spree::Taxon.class_eval do
  has_attached_file :banner,
      styles: { normal: '850x300>', preview: '440x140>' },
      default_style: :normal,
      url: '/spree/taxons/:id/:style/:basename.:extension',
      path: ':rails_root/public/spree/taxons/:id/:style/:basename.:extension',
      default_url: '/assets/default_banner.png'

  validates_attachment :banner,
      content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end