# LLM Orchestra Configuration for eddi-lab

This directory contains LLM Orchestra configuration specific to the eddi-lab ecosystem.

## Agent Roles

The `roles/` directory contains specialized agent roles for different aspects of eddi-lab development:

- **dancer**: Movement analysis and gesture interpretation expert
- **designer**: UX and spatial design specialist for interactive installations  
- **engineer**: Software engineering with TDD and performance focus
- **director**: AI orchestration and spatial intelligence expert
- **researcher**: Academic research and experimental design specialist
- **device_specialist**: Hardware control and real-time systems expert

## Ensembles

The `ensembles/` directory contains pre-configured multi-agent workflows:

- **architecture_review**: Multi-perspective technical architecture review
- **research_validation**: Academic validation for Skeleton-MHI research
- **gesture_analysis**: Comprehensive gesture-to-environment mapping analysis

## Usage

From the eddi-lab root directory, llm-orc will automatically discover and use these configurations:

```bash
# List available roles and ensembles
llm-orc list-ensembles

# Run an ensemble
llm-orc run architecture_review "Analyze the WebSocket API design for real-time pose data streaming"

# Run gesture analysis
llm-orc run gesture_analysis "How should a raised hand gesture map to lighting in a performance space?"
```

## Configuration

The `config.yaml` file defines project-specific settings including:
- Default models for development vs production
- GitHub integration settings
- Model profiles and cost optimization

This configuration is shared across the team and version-controlled to ensure consistent LLM Orchestra behavior for eddi-lab development.