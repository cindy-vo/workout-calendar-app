FROM python:3.10 as python-base
RUN mkdir code
WORKDIR  /code
COPY /pyproject.toml /code
RUN pip3 install poetry
RUN poetry config virtualenvs.create false
RUN poetry install --no-root
COPY . .
CMD ["gunicorn", "-w", "4", "-k", "uvicorn.workers.UvicornWorker", "main:app", "--bind", "0.0.0.0:8000"]