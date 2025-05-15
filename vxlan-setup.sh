#!/bin/bash

# VXLAN post-deployment setup script
# Run this after 'sudo clab deploy' completes

echo "Setting up VXLAN connectivity..."

# Add missing routes for underlay connectivity
echo "Adding underlay routes..."
docker exec clab-evpn-fabric-leaf1 ip route add 172.20.21.0/24 via 172.20.20.1 2>/dev/null || echo "Route to 172.20.21.0/24 already exists on leaf1"
docker exec clab-evpn-fabric-leaf2 ip route add 172.20.20.0/24 via 172.20.21.1 2>/dev/null || echo "Route to 172.20.20.0/24 already exists on leaf2"

# Verify connectivity
echo "Testing underlay connectivity..."
if docker exec clab-evpn-fabric-leaf1 ping -c 1 172.20.21.6 > /dev/null 2>&1; then
    echo "✓ Leaf1 can reach leaf2 underlay (172.20.21.6)"
else
    echo "✗ Leaf1 cannot reach leaf2 underlay"
fi

if docker exec clab-evpn-fabric-leaf2 ping -c 1 172.20.20.5 > /dev/null 2>&1; then
    echo "✓ Leaf2 can reach leaf1 underlay (172.20.20.5)"
else
    echo "✗ Leaf2 cannot reach leaf1 underlay"
fi

# Test VXLAN connectivity
echo "Testing VXLAN connectivity..."
if docker exec clab-evpn-fabric-leaf1 ping -c 1 10.100.0.2 > /dev/null 2>&1; then
    echo "✓ VXLAN connectivity working (leaf1 -> leaf2)"
else
    echo "✗ VXLAN connectivity not working"
fi

if docker exec clab-evpn-fabric-leaf2 ping -c 1 10.100.0.1 > /dev/null 2>&1; then
    echo "✓ VXLAN connectivity working (leaf2 -> leaf1)"
else
    echo "✗ VXLAN connectivity not working"
fi

echo "Setup complete!"
