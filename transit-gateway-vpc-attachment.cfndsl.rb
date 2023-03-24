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

  Condition(:HasTransitGatewayRouteTableId, FnNot(FnEquals(Ref(:TransitGatewayRouteTableId),'')))
  EC2_TransitGatewayRoute(:VpcGatewayRoute) do
    Condition(:HasTransitGatewayRouteTableId)
    Blackhole 'false'
    DestinationCidrBlock Ref(:VpcCidr)
    TransitGatewayAttachmentId Ref(:NetworkVpcGatewayAttachment)
    TransitGatewayRouteTableId Ref(:TransitGatewayRouteTableId)
  end

  Condition(:HasRouteTableIds, FnNot(FnEquals(FnJoin('', Ref(:RouteTableIds)),'')))
  tgw_routes = external_parameters.fetch(:tgw_routes, [])
  external_parameters.fetch(:max_availability_zones, 0).times do |az|
    tgw_routes.each_with_index do |dest_cidr, index|

      EC2_Route("CustomRoute#{az}#{index}") do
        Condition(:HasRouteTableIds)
        DependsOn['NetworkVpcGatewayAttachment']
        RouteTableId FnSelect(az, Ref(:RouteTableIds))
        DestinationCidrBlock dest_cidr
        TransitGatewayId Ref(:TransitGatewayId)
      end

    end
  end

  
  end
