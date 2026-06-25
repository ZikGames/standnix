{
  self,
  inputs,
  options,
  lib,
  config,
  ...
}:
{
  # flake.nixosModules.undertaleModTool = { }: { };
  # flake.homeModules.undertaleModTool = { }: { };
  # perSystem =
  #   {
  #     lib,
  #     buildDotnetModule,
  #     dotnetCorePackages,
  #     fetchFromGitHub,
  #     ...
  #   }:
  #   {
  #     pkgs.packages.undertaleModTool = buildDotnetModule {
  #       pname = "undertaleModTool";
  #       version = "1.0.0";

  #       src = fetchFromGitHub {
  #         owner = "username";
  #         repo = "csharp-repo";
  #         rev = "v";
  #         hash = ""; # Оставь пустым для получения хэша исходников (как и в Python)
  #       };

  #       # Указываем нужную версию SDK и Runtime
  #       dotnet-sdk = dotnetCorePackages.sdk_10_0;
  #       dotnet-runtime = dotnetCorePackages.runtime_10_0;

  #       # Если файл .csproj или .sln лежит не в корне репозитория, укажи путь:
  #       projectFile = "src/UndertaleModTool";

  #       # Хэш NuGet-зависимостей (обязателен!)
  #       # Как получить: поставь пустую строку `""` или `lib.fakeHash`.
  #       # При сборке Nix выдаст ошибку и покажет правильный хэш для NuGet-пакетов.
  #       nugetDeps = lib.fakeHash;
  #       dotnetPublishFlags = [
  #         # "-p:PublishSingleFile=true" # Пример: упаковать в один исполняемый файл
  #         "--no-self-contained" # Часто используется в Nix, чтобы не дублировать рантайм
  #       ];

  #       # Зависимости, нужные для сборки (если программа использует нативные библиотеки)
  #       nativeBuildInputs = [ ];
  #       buildInputs = [ ];

  #     };
  #   };
}
