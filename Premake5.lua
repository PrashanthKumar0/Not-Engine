workspace "Not Engine"
	architecture "x64"
	startproject "Not Editor"
	configurations 
	{ 	
		"Debug", 
		"Release" 
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

UtilsDir = {}
UtilsDir["GLFW"] = "Utils/GLFW"
UtilsDir["GLAD"] = "Utils/GLAD"
UtilsDir["ImGui"] = "Utils/IMGUI"
UtilsDir["glm"] = "Utils/GLM"
UtilsDir["stb_image"] = "Utils/STBI"
UtilsDir["Drivers"] = "Utils/Drivers"

group "Dependencies"
	include "Utils/GLAD"
	include "Utils/GLFW"
	include "Utils/IMGUI"
group ""

project "Not Engine"
	location "Not Engine"
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
	}

	links 
	{
		"GLAD",
		"GLFW",
		"IMGUI",
		"opengl32.lib"
	}

	defines
	{
		"GLFW_INCLUDE_NONE",
		"IMGUI_IMPL_OPENGL_LOADER_GLAD"
	}

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	filter "system:windows"
		systemversion "latest"

    filter "configurations:Debug"
        defines "NE_DEBUG"
		runtime "DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "NE_RELEASE"
		runtime "RELEASE"
        optimize "On"


project "Not Editor"
	location "Not Editor"
	kind "ConsoleApp"
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
		"Utils/STBI/**.cpp",
		"Utils/Drivers/**.h",
		"Utils/Drivers/**.cpp",
	}

	includedirs
	{
		"Not Engine/Source",
		"%{UtilsDir.GLAD}/include",
		"%{UtilsDir.GLFW}/include",
		"%{UtilsDir.ImGui}",
		"%{UtilsDir.ImGui}/misc/cpp",
		"%{UtilsDir.glm}",
		"%{UtilsDir.stb_image}",
		"%{UtilsDir.Drivers}",
	}

	links 
	{ 
		"Not Engine",
		"GLAD",
		"GLFW",
		"IMGUI",
		"opengl32.lib",
	}

	defines
	{
		"GLFW_INCLUDE_NONE",
		"IMGUI_IMPL_OPENGL_LOADER_GLAD",
	}

	debugdir(".\\")
	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	filter "system:windows"
		systemversion "latest"

    filter "configurations:Debug"
        defines "NE_DEBUG"
		runtime "DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "NE_RELEASE"
		runtime "RELEASE"
        optimize "On"