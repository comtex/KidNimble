class Asset < ActiveRecord::Base
  belongs_to :camp
  attr_accessor :_destroy
  
  has_attached_file :asset, 
                    :styles => { :large => "250x225#", :medium => "120x100#", :thumb => "50x50#" },
                    :url => '/:class/:id/:style.:content_type_extension',
                    :path => ':rails_root/public/assets/:id/:style.:content_type_extension'
                    #,:processors => lambda { |a| a.video? ? [ :video_thumbnail ] : [ :thumbnail ] }
  
  def video?
    [ 'application/x-mp4',
      'video/mpeg',
      'video/quicktime',
      'video/x-la-asf',
      'video/x-ms-asf',
      'video/x-msvideo',
      'video/x-sgi-movie',
      'video/x-flv',
      'flv-application/octet-stream',
      'video/3gpp',
      'video/3gpp2',
      'video/3gpp-tt',
      'video/BMPEG',
      'video/BT656',
      'video/CelB',
      'video/DV',
      'video/H261',
      'video/H263',
      'video/H263-1998',
      'video/H263-2000',
      'video/H264',
      'video/JPEG',
      'video/MJ2',
      'video/MP1S',
      'video/MP2P',
      'video/MP2T',
      'video/mp4',
      'video/MP4V-ES',
      'video/MPV',
      'video/mpeg4',
      'video/mpeg4-generic',
      'video/nv',
      'video/parityfec',
      'video/pointer',
      'video/raw',
      'video/rtx' ].include?(asset.content_type)
  end
  
end
