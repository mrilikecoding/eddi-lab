# Legacy System Migration

## Lumi (PI3E) - Working Legacy Implementation

### Current Status
- **Status**: Functional Kinect-based lighting control system
- **Location**: `eddi/src/lumi.py` and related components
- **Purpose**: Original thesis implementation for movement-responsive environments
- **Key Components**: OSC/DMX communication, spatial zones, gesture recognition

### Migration Strategy
```
Legacy Lumi → Analysis → Eddi Architecture → Component Migration → Feature Parity → Deprecation
```

### Critical Legacy Components to Migrate

| Legacy Component | Target System | Description |
|------------------|---------------|-------------|
| `lumi.py` | Eddi-pad | Main orchestration and device coordination |
| `director.py` | Eddi | AI decision-making and spatial intelligence |
| `mhi.py` | Skeleton-MHI | Motion History Images implementation |
| `spatial_light_controller.py` | Eddi-pad | Device control and hardware abstraction |
| `sequencer.py` | Eddi | Temporal coordination and timing |

### Performance Targets

Legacy system performance must be maintained or improved:
- **Device Control**: <1ms latency for device commands
- **End-to-End Pipeline**: <100ms total latency
- **Gesture Segmentation**: Real-time processing at 30fps minimum
- **WebSocket Communication**: <10ms between components

### Migration Validation

Each migrated component must:
- [ ] Maintain or improve performance characteristics
- [ ] Pass integration tests with real hardware
- [ ] Support backward compatibility during transition
- [ ] Include comprehensive test coverage
- [ ] Document behavioral differences from legacy system

### Architecture Principles

- **Performance First**: Sub-millisecond latency for device communication
- **Device Agnostic**: Unified interface for virtual and physical targets
- **Spatial Intelligence**: Leverage proven spatial zone models
- **Separation of Concerns**: Clear boundaries between pose analysis, gesture segmentation, spatial response, and device control