
FEATURES_DIR = ./Features

feature:
	@if [ -z "$(NAME)" ]; then \
	  echo "Usage: make feature NAME=FeatureName"; \
	  exit 1; \
	fi
	mkdir -p $(FEATURES_DIR)/$(NAME)/Presentation
	mkdir -p $(FEATURES_DIR)/$(NAME)/Domain/UseCase
	mkdir -p $(FEATURES_DIR)/$(NAME)/Domain/Repository
	mkdir -p $(FEATURES_DIR)/$(NAME)/Data/Repository
	mkdir -p $(FEATURES_DIR)/$(NAME)/Data/DataSource
	mkdir -p $(FEATURES_DIR)/$(NAME)/Data/DTO
	mkdir -p $(FEATURES_DIR)/$(NAME)/Data/Mapper
	@echo "✅ Created feature: $(FEATURES_DIR)/$(NAME)"
