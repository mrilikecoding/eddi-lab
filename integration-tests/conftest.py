"""Pytest configuration for integration tests."""

import pytest


@pytest.fixture
def sample_pose_data():
    """Sample pose data for integration testing."""
    return {
        "timestamp": 1234567890.0,
        "keypoints": [
            {"x": 0.5, "y": 0.5, "confidence": 0.9},
            {"x": 0.4, "y": 0.6, "confidence": 0.8},
        ]
    }


@pytest.fixture  
def sample_gesture_segment():
    """Sample gesture segment for integration testing."""
    return {
        "start_time": 1234567890.0,
        "end_time": 1234567892.0,
        "confidence": 0.85,
        "gesture_type": "wave"
    }