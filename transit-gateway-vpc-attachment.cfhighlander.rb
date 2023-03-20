CfhighlanderTemplate do
  
    Parameters do
        ComponentParam 'TransitGatewayId'
        ComponentParam 'TransitGatewayRouteTableId'
        ComponentParam 'VPCId'
        ComponentParam 'VpcCidr'
        ComponentParam 'SubnetIds', type: 'CommaDelimitedList'
        ComponentParam 'RouteTableIds', '', type: 'CommaDelimitedList'
    end
end 