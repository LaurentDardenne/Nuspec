using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace NugetSchema
{
    // 
    // Ce code source a été automatiquement généré par xsd, Version=4.0.30319.33440.
    // xsd was extractd and adapted from : https://github.com/NuGet/NuGet.Client/blob/dev/src/NuGet.Core/NuGet.Packaging/compiler/resources/nuspec.xsd
    // 


    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    [System.Xml.Serialization.XmlRootAttribute(Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd", IsNullable = false)]
    public partial class package
    {

        private packageMetadata metadataField;

        private packageFile[] filesField;

        /// <remarks/>
        public packageMetadata metadata
        {
            get
            {
                return this.metadataField;
            }
            set
            {
                this.metadataField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlArrayAttribute(IsNullable = true)]
        [System.Xml.Serialization.XmlArrayItemAttribute("file", IsNullable = false)]
        public packageFile[] files
        {
            get
            {
                return this.filesField;
            }
            set
            {
                this.filesField = value;
            }
        }
        /// <summary>
        /// !!Added !! Make sure the list of files  has any content
        /// </summary>
        public bool ShouldSerializefiles()
        {
            return !(filesField == null || filesField.Length <= 0);
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class packageMetadata
    {

        private string idField;

        private string versionField;

        private string titleField;

        private string authorsField;

        private string ownersField;

        private string licenseUrlField;

        private string projectUrlField;

        private string iconUrlField;

        private bool requireLicenseAcceptanceField;

        private bool requireLicenseAcceptanceFieldSpecified;

        private bool developmentDependencyField;

        private bool developmentDependencyFieldSpecified;

        private string descriptionField;

        private string summaryField;

        private string releaseNotesField;

        private string copyrightField;

        private string languageField;

        private string tagsField;

        private bool serviceableField;

        private bool serviceableFieldSpecified;

        private packageMetadataPackageType[] packageTypesField;

        private packageMetadataDependencies dependenciesField;

        private packageMetadataFrameworkAssembly[] frameworkAssembliesField;

        private packageMetadataReferences referencesField;

        private packageMetadataContentFiles contentFilesField;

        private string minClientVersionField;

        public packageMetadata()
        {
            this.languageField = "en-US";
        }

        /// <remarks/>
        public string id
        {
            get
            {
                return this.idField;
            }
            set
            {
                this.idField = value;
            }
        }

        /// <remarks/>
        public string version
        {
            get
            {
                return this.versionField;
            }
            set
            {
                this.versionField = value;
            }
        }

        /// <remarks/>
        public string title
        {
            get
            {
                return this.titleField;
            }
            set
            {
                this.titleField = value;
            }
        }

        /// <remarks/>
        public string authors
        {
            get
            {
                return this.authorsField;
            }
            set
            {
                this.authorsField = value;
            }
        }

        /// <remarks/>
        public string owners
        {
            get
            {
                return this.ownersField;
            }
            set
            {
                this.ownersField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(DataType = "anyURI")]
        public string licenseUrl
        {
            get
            {
                return this.licenseUrlField;
            }
            set
            {
                this.licenseUrlField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(DataType = "anyURI")]
        public string projectUrl
        {
            get
            {
                return this.projectUrlField;
            }
            set
            {
                this.projectUrlField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(DataType = "anyURI")]
        public string iconUrl
        {
            get
            {
                return this.iconUrlField;
            }
            set
            {
                this.iconUrlField = value;
            }
        }

        /// <remarks/>
        public bool requireLicenseAcceptance
        {
            get
            {
                return this.requireLicenseAcceptanceField;
            }
            set
            {
                this.requireLicenseAcceptanceField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool requireLicenseAcceptanceSpecified
        {
            get
            {
                return this.requireLicenseAcceptanceFieldSpecified;
            }
            set
            {
                this.requireLicenseAcceptanceFieldSpecified = value;
            }
        }

        /// <remarks/>
        public bool developmentDependency
        {
            get
            {
                return this.developmentDependencyField;
            }
            set
            {
                this.developmentDependencyField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool developmentDependencySpecified
        {
            get
            {
                return this.developmentDependencyFieldSpecified;
            }
            set
            {
                this.developmentDependencyFieldSpecified = value;
            }
        }

        /// <remarks/>
        public string description
        {
            get
            {
                return this.descriptionField;
            }
            set
            {
                this.descriptionField = value;
            }
        }

        /// <remarks/>
        public string summary
        {
            get
            {
                return this.summaryField;
            }
            set
            {
                this.summaryField = value;
            }
        }

        /// <remarks/>
        public string releaseNotes
        {
            get
            {
                return this.releaseNotesField;
            }
            set
            {
                this.releaseNotesField = value;
            }
        }

        /// <remarks/>
        public string copyright
        {
            get
            {
                return this.copyrightField;
            }
            set
            {
                this.copyrightField = value;
            }
        }

        /// <remarks/>
        [System.ComponentModel.DefaultValueAttribute("en-US")]
        public string language
        {
            get
            {
                return this.languageField;
            }
            set
            {
                this.languageField = value;
            }
        }

        /// <remarks/>
        public string tags
        {
            get
            {
                return this.tagsField;
            }
            set
            {
                this.tagsField = value;
            }
        }

        /// <remarks/>
        public bool serviceable
        {
            get
            {
                return this.serviceableField;
            }
            set
            {
                this.serviceableField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool serviceableSpecified
        {
            get
            {
                return this.serviceableFieldSpecified;
            }
            set
            {
                this.serviceableFieldSpecified = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlArrayItemAttribute("packageType", IsNullable = false)]
        public packageMetadataPackageType[] packageTypes
        {
            get
            {
                return this.packageTypesField;
            }
            set
            {
                this.packageTypesField = value;
            }
        }

        /// <remarks/>
        public packageMetadataDependencies dependencies
        {
            get
            {
                return this.dependenciesField;
            }
            set
            {
                this.dependenciesField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlArrayItemAttribute("frameworkAssembly", IsNullable = false)]
        public packageMetadataFrameworkAssembly[] frameworkAssemblies
        {
            get
            {
                return this.frameworkAssembliesField;
            }
            set
            {
                this.frameworkAssembliesField = value;
            }
        }

        /// <remarks/>
        public packageMetadataReferences references
        {
            get
            {
                return this.referencesField;
            }
            set
            {
                this.referencesField = value;
            }
        }

        /// <remarks/>
        public packageMetadataContentFiles contentFiles
        {
            get
            {
                return this.contentFilesField;
            }
            set
            {
                this.contentFilesField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string minClientVersion
        {
            get
            {
                return this.minClientVersionField;
            }
            set
            {
                this.minClientVersionField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class packageMetadataPackageType
    {

        private string nameField;

        private string versionField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string name
        {
            get
            {
                return this.nameField;
            }
            set
            {
                this.nameField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string version
        {
            get
            {
                return this.versionField;
            }
            set
            {
                this.versionField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class contentFileEntries
    {

        private string includeField;

        private string excludeField;

        private string buildActionField;

        private bool copyToOutputField;

        private bool copyToOutputFieldSpecified;

        private bool flattenField;

        private bool flattenFieldSpecified;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string include
        {
            get
            {
                return this.includeField;
            }
            set
            {
                this.includeField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string exclude
        {
            get
            {
                return this.excludeField;
            }
            set
            {
                this.excludeField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string buildAction
        {
            get
            {
                return this.buildActionField;
            }
            set
            {
                this.buildActionField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public bool copyToOutput
        {
            get
            {
                return this.copyToOutputField;
            }
            set
            {
                this.copyToOutputField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool copyToOutputSpecified
        {
            get
            {
                return this.copyToOutputFieldSpecified;
            }
            set
            {
                this.copyToOutputFieldSpecified = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public bool flatten
        {
            get
            {
                return this.flattenField;
            }
            set
            {
                this.flattenField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool flattenSpecified
        {
            get
            {
                return this.flattenFieldSpecified;
            }
            set
            {
                this.flattenFieldSpecified = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class referenceGroup
    {

        private reference[] referenceField;

        private string targetFrameworkField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("reference")]
        public reference[] reference
        {
            get
            {
                return this.referenceField;
            }
            set
            {
                this.referenceField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string targetFramework
        {
            get
            {
                return this.targetFrameworkField;
            }
            set
            {
                this.targetFrameworkField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class reference
    {

        private string fileField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string file
        {
            get
            {
                return this.fileField;
            }
            set
            {
                this.fileField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class dependencyGroup
    {

        private dependency[] dependencyField;

        private string targetFrameworkField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("dependency")]
        public dependency[] dependency
        {
            get
            {
                return this.dependencyField;
            }
            set
            {
                this.dependencyField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string targetFramework
        {
            get
            {
                return this.targetFrameworkField;
            }
            set
            {
                this.targetFrameworkField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class dependency
    {

        private string idField;

        private string versionField;

        private string includeField;

        private string excludeField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string id
        {
            get
            {
                return this.idField;
            }
            set
            {
                this.idField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string version
        {
            get
            {
                return this.versionField;
            }
            set
            {
                this.versionField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string include
        {
            get
            {
                return this.includeField;
            }
            set
            {
                this.includeField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string exclude
        {
            get
            {
                return this.excludeField;
            }
            set
            {
                this.excludeField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class packageMetadataDependencies
    {

        private object[] itemsField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("dependency", typeof(dependency))]
        [System.Xml.Serialization.XmlElementAttribute("group", typeof(dependencyGroup))]
        public object[] Items
        {
            get
            {
                return this.itemsField;
            }
            set
            {
                this.itemsField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class packageMetadataFrameworkAssembly
    {

        private string assemblyNameField;

        private string targetFrameworkField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string assemblyName
        {
            get
            {
                return this.assemblyNameField;
            }
            set
            {
                this.assemblyNameField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string targetFramework
        {
            get
            {
                return this.targetFrameworkField;
            }
            set
            {
                this.targetFrameworkField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class packageMetadataReferences
    {

        private object[] itemsField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("group", typeof(referenceGroup))]
        [System.Xml.Serialization.XmlElementAttribute("reference", typeof(reference))]
        public object[] Items
        {
            get
            {
                return this.itemsField;
            }
            set
            {
                this.itemsField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class packageMetadataContentFiles
    {

        private contentFileEntries[] itemsField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("files")]
        public contentFileEntries[] Items
        {
            get
            {
                return this.itemsField;
            }
            set
            {
                this.itemsField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class packageFile
    {

        private string srcField;

        private string targetField;

        private string excludeField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string src
        {
            get
            {
                return this.srcField;
            }
            set
            {
                this.srcField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string target
        {
            get
            {
                return this.targetField;
            }
            set
            {
                this.targetField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string exclude
        {
            get
            {
                return this.excludeField;
            }
            set
            {
                this.excludeField = value;
            }
        }
    }
}
