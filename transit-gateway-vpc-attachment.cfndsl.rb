CloudFormation do

    default_tags = external_parameters.fetch(:default_tags, [])
  
    EC2_TransitGatewayAttachment(:NetworkVpcGatewayAttachment) do
      TransitGatewayId Ref(:TransitGatewayId)
      VpcId Ref(:VPCId)
      SubnetIds Ref(:SubnetIds)
      Tags default_tags
    end

    EC2_TransitGatewayRoute(:VpcGatewayRoute) do
      Blackhole 'false'
      DestinationCidrBlock Ref(:VpcCidr)
      TransitGatewayAttachmentId Ref(:NetworkVpcGatewayAttachment)
      TransitGatewayRouteTableId Ref(:TransitGatewayRouteTableId)
    end
  
  end