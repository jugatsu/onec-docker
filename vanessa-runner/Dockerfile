ARG DOCKER_USERNAME
FROM ${DOCKER_USERNAME}/oscript:1.0.21
LABEL maintainer="Anton Kvashenkin <anton.jugatsu@gmail.com> (@jugatsu)"

ARG runner_ver=1.7.0

RUN opm install vanessa-runner@$runner_ver \
  # https://github.com/silverbulleters/vanessa-runner/pull/301
  && sed -i 's/#Использовать JSON/#Использовать json/g' \
    /usr/share/oscript/lib/vanessa-runner/src/Модули/ГенерацияОтчетов.os

ENTRYPOINT ["runner"]
CMD ["help"]
