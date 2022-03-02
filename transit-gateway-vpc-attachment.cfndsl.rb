CloudFormation do

  default_tags = external_parameters.fetch(:default_tags, {})

  tags = []
  default_tags.each do |key, value|
    tags << {Key: key, Value: value}
  end unless default_tags.nil?
  
  EC2_TransitGatewayAttachment(:NetworkVpcGatewayAttachment) do
    TransitGatewayId Ref(:TransitGatewayId)
    VpcId Ref(:VPCId)
    SubnetIds Ref(:SubnetIds)
    Tags tags
  end

  EC2_TransitGatewayRoute(:VpcGatewayRoute) do
    Blackhole 'false'
    DestinationCidrBlock Ref(:VpcCidr)
    TransitGatewayAttachmentId Ref(:NetworkVpcGatewayAttachment)
    TransitGatewayRouteTableId Ref(:TransitGatewayRouteTableId)
  end
  
  end