CfhighlanderTemplate do
  
    Parameters do
        ComponentParam 'TransitGatewayId'
        ComponentParam 'TransitGatewayRouteTableId'
        ComponentParam 'VPCId'
        ComponentParam 'VpcCidr'
        ComponentParam 'SubnetIds', type: 'CommaDelimitedList'
    end
end 