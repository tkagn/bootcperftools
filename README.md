# bootcperftools




## GitHub Actions workflow

1. Check out your repo.
2. Build a container image.
3. Authenticate with Quay.io using GitHub secrets.
4. Push the image to your Quay registry.

```yaml
name: Build and Push to Quay

on:
  push:
    branches:
      - main
  workflow_dispatch:  # allows manual triggering

jobs:
  build-and-push:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout source
        uses: actions/checkout@v4

      - name: Log in to Quay.io
        uses: docker/login-action@v3
        with:
          registry: quay.io
          username: ${{ secrets.QUAY_USERNAME }}
          password: ${{ secrets.QUAY_PASSWORD }}

      - name: Build container image
        run: |
          IMAGE_NAME=quay.io/${{ secrets.QUAY_ORG }}/bootcperftools
          docker build -t $IMAGE_NAME:${{ github.sha }} .
          docker tag $IMAGE_NAME:${{ github.sha }} $IMAGE_NAME:latest

      - name: Push container image
        run: |
          IMAGE_NAME=quay.io/${{ secrets.QUAY_ORG }}/bootcperftools
          docker push $IMAGE_NAME:${{ github.sha }}
          docker push $IMAGE_NAME:latest
```

