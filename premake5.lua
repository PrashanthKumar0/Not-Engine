workspace "Not"
	architecture "x64"
	startproject "NotEditor"
	configurations 
	{ 	
		"Debug", 
		"Release" 
	}

	flags
	{
		"MultiProcessorCompile"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

UtilsDir = {}
UtilsDir["GLFW"] = "Utils/GLFW"
UtilsDir["GLAD"] = "Utils/GLAD"
UtilsDir["ImGui"] = "Utils/IMGUI"
UtilsDir["glm"] = "Utils/GLM"
UtilsDir["stb_image"] = "Utils/STBI"
UtilsDir["Drivers"] = "Utils/Drivers"
UtilsDir["spdlog"] = "Utils/spdlog"

group "Dependencies"
	include "Utils/GLAD"
	include "Utils/GLFW"
	include "Utils/IMGUI"
group ""

project "NotEngine"
	location "NotEngine"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

    files 
	{ 
		"%{prj.name}/Source/**.h",
		"%{prj.name}/Source/**.cpp" ,
		"Utils/GLM/glm/**.hpp",
		"Utils/GLM/glm/**.inl",
		"Utils/STBI/**.h" ,
		"Utils/STBI/**.cpp" ,
		"Utils/Drivers/**.h",
		"Utils/Drivers/**.cpp",
	}

	includedirs
	{
		"%{UtilsDir.GLAD}/include",
		"%{UtilsDir.GLFW}/include",
		"%{UtilsDir.ImGui}",
		"%{UtilsDir.ImGui}/misc/cpp",
		"%{UtilsDir.glm}",
		"%{UtilsDir.stb_image}",
		"%{UtilsDir.Drivers}",
		"%{UtilsDir.spdlog}/include",

	}

	links 
	{
		"GLAD",
		"GLFW",
		"IMGUI",
	}

	defines
	{
		"GLFW_INCLUDE_NONE",
		"IMGUI_IMPL_OPENGL_LOADER_GLAD"
	}

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	filter "system:linux"
		systemversion "latest"
		links
		{
			"dl",
			"pthread",
			"GL",
		}

	filter "system:windows"
		systemversion "latest"
		links
		{
			"opengl32"
		}

	filter "action:gmake*"
		defines "W_GCC"
	
	filter "action:vs*"
		defines "W_MSVC"

    filter "configurations:Debug"
        defines "NE_DEBUG"
		runtime "DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "NE_RELEASE"
		runtime "RELEASE"
        optimize "On"


project "NotEditor"
	location "NotEditor"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

    files 
	{ 
		"%{prj.name}/Source/**.h" ,
		"%{prj.name}/Source/**.cpp" ,
		"Utils/GLM/glm/**.hpp",
		"Utils/GLM/glm/**.inl",
		"Utils/STBI/**.h" ,
		"Utils/STBI/**.cpp",
		"Utils/Drivers/**.h",
		"Utils/Drivers/**.cpp",
	}

	includedirs
	{
		"NotEngine/Source",
		"%{UtilsDir.GLAD}/include",
		"%{UtilsDir.GLFW}/include",
		"%{UtilsDir.ImGui}",
		"%{UtilsDir.ImGui}/misc/cpp",
		"%{UtilsDir.glm}",
		"%{UtilsDir.stb_image}",
		"%{UtilsDir.Drivers}",
		"%{UtilsDir.spdlog}/include",
	}

	links 
	{ 
		"NotEngine",
		"GLAD",
		"GLFW",
		"IMGUI",
	}

	defines
	{
		"GLFW_INCLUDE_NONE",
		"IMGUI_IMPL_OPENGL_LOADER_GLAD",
	}

	debugdir("./")
	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	filter "system:linux"
	systemversion "latest"
	links
	{
		"dl",
		"pthread",
		"GL",
	}

	filter "system:windows"
		systemversion "latest"
		files { "%{prj.name}/Platforms/Windows/Resources/NotRes.rc", "%{prj.name}/Platforms/Windows/Resources/icon.ico"}
		links
		{
			"opengl32"
		}

    filter "configurations:Debug"
        defines "NE_DEBUG"
		runtime "DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "NE_RELEASE"
		runtime "RELEASE"
        optimize "On"


project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

    files 
	{ 
		"%{prj.name}/Source/**.h" ,
		"%{prj.name}/Source/**.cpp" ,
		"Utils/GLM/glm/**.hpp",
		"Utils/GLM/glm/**.inl",
		"Utils/STBI/**.h" ,
		"Utils/STBI/**.cpp",
		"Utils/Drivers/**.h",
		"Utils/Drivers/**.cpp",
	}

	includedirs
	{
		"NotEngine/Source",
		"%{UtilsDir.GLAD}/include",
		"%{UtilsDir.GLFW}/include",
		"%{UtilsDir.ImGui}",
		"%{UtilsDir.ImGui}/misc/cpp",
		"%{UtilsDir.glm}",
		"%{UtilsDir.stb_image}",
		"%{UtilsDir.Drivers}",
		"%{UtilsDir.spdlog}/include",
	}

	links 
	{ 
		"NotEngine",
		"GLAD",
		"GLFW",
		"IMGUI",
	}

	defines
	{
		"NotApp",
		"GLFW_INCLUDE_NONE",
		"IMGUI_IMPL_OPENGL_LOADER_GLAD",
	}

	debugdir("./")
	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	filter "system:linux"
		systemversion "latest"
		links
		{
			"dl",
			"pthread",
			"GL",
		}

	filter "system:windows"
		systemversion "latest"
		links
		{
			"opengl32"
		}

    filter "configurations:Debug"
        defines "NE_DEBUG"
		runtime "DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "NE_RELEASE"
		runtime "RELEASE"
        optimize "On"